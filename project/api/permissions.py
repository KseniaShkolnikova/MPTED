from django.core.exceptions import ObjectDoesNotExist
from rest_framework import permissions


def is_admin_user(user):
    return bool(
        user
        and user.is_authenticated
        and (user.is_staff or user.is_superuser)
    )


def is_student_user(user):
    if not user or not user.is_authenticated:
        return False

    try:
        user.student_profile
    except ObjectDoesNotExist:
        return False

    return True


class IsAdminOrMobileStudent(permissions.BasePermission):
    message = (
        "API доступен только администратору. "
        "Ученики могут использовать только JSON mobile API."
    )

    def _is_mobile_api_request(self, request):
        resolver_match = getattr(request, "resolver_match", None)
        namespaces = getattr(resolver_match, "namespaces", []) or []
        return "mobile_api" in namespaces or request.path.startswith("/api/mobile/")

    def _is_browsable_api_request(self, request):
        renderer = getattr(request, "accepted_renderer", None)
        return getattr(renderer, "format", None) == "api"

    def has_permission(self, request, view):
        user = request.user
        if not user or not user.is_authenticated:
            return False

        if is_admin_user(user):
            return True

        if not self._is_mobile_api_request(request):
            return False

        if not is_student_user(user):
            return False

        if self._is_browsable_api_request(request):
            return False

        if request.method in permissions.SAFE_METHODS:
            return True

        return request.method in getattr(view, "student_write_methods", set())

    def has_object_permission(self, request, view, obj):
        if is_admin_user(request.user):
            return True

        if request.method in permissions.SAFE_METHODS:
            return True

        can_modify = getattr(view, "can_modify_student_object", None)
        return bool(can_modify and can_modify(request, obj))

class CustomPermission(permissions.DjangoModelPermissions):
    perms_map = {
        'GET': ['%(app_label)s.view_%(model_name)s'],
        'OPTIONS': ['%(app_label)s.view_%(model_name)s'],
        'HEAD': ['%(app_label)s.view_%(model_name)s'],
        'POST': ['%(app_label)s.add_%(model_name)s'],
        'PUT': ['%(app_label)s.change_%(model_name)s'],
        'PATCH': ['%(app_label)s.change_%(model_name)s'],
        'DELETE': ['%(app_label)s.delete_%(model_name)s'],
    }
