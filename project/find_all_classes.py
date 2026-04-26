import os
import django
import inspect
from pathlib import Path

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'project.settings')
django.setup()


app_path = Path(__file__).parent / 'teacher_portal'

print("=" * 50)
print("ПОИСК ВСЕХ КЛАССОВ В ПРОЕКТЕ")
print("=" * 50)


for py_file in app_path.rglob('*.py'):
    if py_file.name.startswith('_'):
        continue

    print(f"\n📄 Файл: {py_file.relative_to(app_path.parent)}")

    try:

        module_name = f"teacher_portal.{py_file.stem}"
        if py_file.parent != app_path:

            rel_path = py_file.relative_to(app_path)
            module_name = f"teacher_portal.{'.'.join(rel_path.with_suffix('').parts)}"

        module = __import__(module_name, fromlist=[''])


        classes = []
        for name, obj in inspect.getmembers(module):
            if inspect.isclass(obj) and obj.__module__ == module_name:
                classes.append(name)

        if classes:
            print(f"   Найдены классы: {', '.join(classes)}")
        else:
            print("   Классов не найдено")

    except Exception as e:
        print(f"   Ошибка при импорте: {e}")
