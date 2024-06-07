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
directory_path = '/Users/unitymastery/Documents/GitHub/stay_travel_v3_api/'
total_lines = count_dart_lines(directory_path)
print(f'Общее количество строк кода во всех файлах Dart: {total_lines}')
import os

def list_directory_contents(directory_path):
    catalog = ""
    
    for root, dirs, files in os.walk(directory_path):
        level = root.replace(directory_path, '').count(os.sep)
        indent = ' ' * 4 * (level)
        catalog += f'{indent}{os.path.basename(root)}/\n'
        
        subindent = ' ' * 4 * (level + 1)
        for file in files:
            catalog += f'{subindent}{file}\n'
    
    return catalog

# Пример использования:
directory_path = "/Users/unitymastery/Documents/GitHub/stay_travel_v3_api/app"
catalog = list_directory_contents(directory_path)
print(catalog)



