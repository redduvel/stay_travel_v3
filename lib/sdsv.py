import os

def count_dart_lines(directory):
    total_lines = 0

    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.py'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                    total_lines += len(lines)
    
    return total_lines

# Пример использования:
directory_path = 'D:/stay_travel_v3_api/'
total_lines = count_dart_lines(directory_path)
print(f'Общее количество строк кода во всех файлах Dart: {total_lines}')
