from django.conf import settings
from django.db import DatabaseError, connection
from django.shortcuts import redirect
from django.urls import reverse


class AuditContextMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        self._set_current_user_id(getattr(request.user, "id", None))
        try:
            return self.get_response(request)
        finally:
            self._set_current_user_id(None)

    def _set_current_user_id(self, user_id):
        if connection.vendor != "postgresql":
            return

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    "SELECT set_config('app.current_user_id', %s, false)",
                    [str(user_id) if user_id is not None else ""],
                )
        except DatabaseError:
            # Do not break the request flow if audit context cannot be set.
            return


class StudentEmailVerificationMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        if self._must_verify_email(request):
            return redirect('student_email_verify')
        return self.get_response(request)

    def _must_verify_email(self, request):
        user = getattr(request, 'user', None)
        if not user or not user.is_authenticated:
            return False

        if user.is_superuser or user.groups.filter(name='admin').exists():
            return False

        if not user.groups.filter(name='student').exists():
            return False

        profile = getattr(user, 'student_profile', None)
        if not profile or profile.email_verified:
            return False

        request_path = request.path
        static_url = getattr(settings, 'STATIC_URL', '/static/')
        media_url = getattr(settings, 'MEDIA_URL', '/media/')
        if static_url and request_path.startswith(static_url):
            return False
        if media_url and request_path.startswith(media_url):
            return False

        allowed_paths = {
            reverse('student_email_verify'),
            reverse('student_email_verify_resend'),
            reverse('logout_view'),
        }
        return request_path not in allowed_paths
