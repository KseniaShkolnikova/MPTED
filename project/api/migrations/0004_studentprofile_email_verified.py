

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auditlog'),
    ]

    operations = [
        migrations.AddField(
            model_name='studentprofile',
            name='email_verified',
            field=models.BooleanField(default=False, verbose_name='Email подтвержден'),
        ),
    ]
