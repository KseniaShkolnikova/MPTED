from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.exceptions import PermissionDenied
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response

from .permissions import is_admin_user, is_student_user


class StudentOrAdminAuthToken(ObtainAuthToken):
    renderer_classes = [JSONRenderer]

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(
            data=request.data,
            context={"request": request},
        )
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]

        if not (is_admin_user(user) or is_student_user(user)):
            raise PermissionDenied("Токен API доступен только админу или ученику.")

        token, _ = Token.objects.get_or_create(user=user)
        return Response({"token": token.key})
