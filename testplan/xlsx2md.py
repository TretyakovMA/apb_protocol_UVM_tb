import pandas as pd

name = input("Имя листа в excel: ")
output_file = f"{name}.md"

# Чтение файла
df = pd.read_excel("testplan.xlsx", sheet_name=name)

# Конвертация в Markdown (без индекса строк)
md_table = df.to_markdown(index=False)

# Формируем итоговый текст: заголовок, двойной перенос для отступа, таблица, пустая строка в конце
final_content = f"# Testplan: {name}\n\n{md_table}\n"

# Сохранение в файл
with open(output_file, "w", encoding="utf-8") as f:
    f.write(final_content)

print(f"✅ Файл '{output_file}' успешно создан!")