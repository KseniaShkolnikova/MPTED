

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='dailyschedule',
            name='is_weekend',
            field=models.BooleanField(default=False, verbose_name='Выходной'),
        ),
        migrations.AlterField(
            model_name='dailyschedule',
            name='week_day',
            field=models.CharField(choices=[('MON', 'Понедельник'), ('TUE', 'Вторник'), ('WED', 'Среда'), ('THU', 'Четверг'), ('FRI', 'Пятница'), ('SAT', 'Суббота'), ('SUN', 'Воскресенье')], max_length=3, verbose_name='День недели'),
        ),
    ]
