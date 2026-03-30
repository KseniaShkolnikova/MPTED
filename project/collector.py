import os
from pathlib import Path

# Расширения для поиска
EXTENSIONS = {
    'html', 'py', 'css', 'yml', 'yaml'
}

# Специальные имена (Dockerfile)
SPECIAL_FILENAMES = {
    'dockerfile', 'Dockerfile'
}

# Игнорируемые папки
IGNORE_DIRS = {
    '.git', '__pycache__', 'node_modules', '.idea', '.vscode',
    'venv', 'env', '.env', 'dist', 'build', 'migrations', '__init__.py'
}

OUTPUT_FILE = 'file_table.txt'

def count_lines(file_path):
    """Считает количество строк в файле"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return sum(1 for _ in f)
    except (UnicodeDecodeError, IOError):
        return 0

def get_size_kb(size_bytes):
    """Конвертирует байты в КБ с двумя знаками после запятой"""
    return round(size_bytes / 1024, 2)

def should_ignore(path):
    parts = path.split(os.sep)
    return any(part in IGNORE_DIRS for part in parts)

def collect_files_with_details(start_path='.'):
    files_data = []
    
    for root, dirs, files in os.walk(start_path):
        # Не заходим в игнорируемые папки
        dirs[:] = [d for d in dirs if d not in IGNORE_DIRS]
        
        for file in files:
            file_path = os.path.join(root, file)
            relative_path = os.path.relpath(file_path, start_path)
            
            if should_ignore(relative_path):
                continue
            
            # Проверяем расширение
            ext = os.path.splitext(file)[1].lower().lstrip('.')
            if ext in EXTENSIONS or file in SPECIAL_FILENAMES:
                try:
                    size_bytes = os.path.getsize(file_path)
                    size_kb = get_size_kb(size_bytes)
                    lines = count_lines(file_path)
                    
                    # Берем только имя файла без пути
                    filename_only = file
                    
                    files_data.append({
                        'filename': filename_only,
                        'fullpath': relative_path,
                        'size_kb': size_kb,
                        'lines': lines,
                        'description': ''  # Пустое описание для заполнения
                    })
                except OSError:
                    continue
    
    # Сортируем по размеру (от больших к маленьким)
    files_data.sort(key=lambda x: x['size_kb'], reverse=True)
    
    # Записываем в файл в формате таблицы
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        # Заголовок таблицы
        f.write("№\tНазвание файла\tОписание\tКол-во строк\tРазмер (КБ)\n")
        f.write("1\t2\t3\t4\t5\n")
        f.write("-" * 80 + "\n")
        
        # Данные
        for idx, file in enumerate(files_data, 1):
            f.write(f"{idx}.\t{file['filename']}\t{file['description']}\t{file['lines']}\t{file['size_kb']:,.2f}\n")
        
        # Итог
        total_files = len(files_data)
        total_lines = sum(f['lines'] for f in files_data)
        total_size = sum(f['size_kb'] for f in files_data)
        
        f.write("-" * 80 + "\n")
        f.write(f"ИТОГО:\t{total_files} файлов\t\t{total_lines} строк\t{total_size:,.2f} КБ\n")
    
    print(f"Найдено {total_files} файлов")
    print(f"Общее количество строк: {total_lines}")
    print(f"Общий размер: {total_size:,.2f} КБ")
    print(f"Таблица сохранена в {OUTPUT_FILE}")
    
    # Покажем первые 20 для примера
    if files_data:
        print("\nПервые 20 файлов:")
        print("№\tНазвание файла\t\tСтрок\tРазмер (КБ)")
        print("-" * 50)
        for idx, file in enumerate(files_data[:20], 1):
            print(f"{idx}\t{file['filename'][:20]:<20}\t{file['lines']}\t{file['size_kb']:,.2f}")

if __name__ == '__main__':
    collect_files_with_details()