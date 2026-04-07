from django.conf import settings
from django.shortcuts import redirect
from django.urls import reverse


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
