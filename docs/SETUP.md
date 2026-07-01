# GD toolkit

> Для отключения alias Microsoft Store для Python

Если `where.exe python` показывает WindowsApps, отключи алиасы:
- Открой Параметры Windows
- Перейди в Приложения
- Открой Дополнительные параметры приложений
- Найди Псевдонимы выполнения приложений и отключи:
    - python.exe
    - python3.exe

> Настройка

```shell
# поиск
winget search python

# установка
winget install --id Python.Python.3.12 -e --source winget --scope user

# находим Python directory
Get-ChildItem "$env:LOCALAPPDATA\Programs\Python" -Directory

# добавляем в PATH (открыть можно через sysdm.cpl)
# C:\Users\userName\AppData\Local\Programs\Python\Python312\Scripts\
# C:\Users\userName\AppData\Local\Programs\Python\Launcher\
# C:\Users\userName\AppData\Local\Programs\Python\Python312\

# проверяем PATH
$env:Path -split ';'

# проверяем версии
python --version
py --version
pip --version
```

```shell
# обновляем pip
py -m pip install --upgrade pip

# Лучше на Windows использовать именно так, а не просто pip install, потому что
# py -m pip гарантирует, что пакет ставится в тот Python, который запускается через Windows Python Launcher
py -m pip install gdtoolkit

# проверяем
gdformat --version
gdlint --version
```

```shell
# устанавливаем pre-commit
py -m pip install pre-commit gdtoolkit

# затем устанавливаем себе в проект (добавляется локально в .git)
pre-commit install

# создаем файл .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: gdformat
        name: gdformat
        entry: gdformat
        language: system
        files: \.gd$

      - id: gdlint
        name: gdlint
        entry: gdlint
        language: system
        files: \.gd$
```

> Для удобного форматирования при сохранении в Rider `Settings -> Tools -> File Watchers`

- `Name:` `GDScript Format`
- `File type:` `GdScript file`
- `Scope:` `Current File`
- `Programm:` `C:\Users\userName\AppData\Local\Programs\Python\Python312\Scripts\gdformat`
- `Arguments:` `$FilePath$`
- `Output path to refresh:` `$FilePath$`
- `Working directory:` `$ModuleFileDir$`
- `Advanced options:` отключаем все
- `Show console:` `Never`

> Чтобы все `scripts` открывались в `IDE`:

- `Editor → Editor Settings → Text Editor → External`: включаем
- `Exec Path:` `C:/JetBrains/JetBrains Rider 2026.1.1/bin/rider64.exe`
- `Exec Flags:` `{project} --line {line} {file}`