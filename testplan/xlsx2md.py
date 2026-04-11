import pandas as pd

name = input("Имя листа в excel:")
output_file = f"{name}.md"

# Чтение файла
df = pd.read_excel("testplan.xlsx", sheet_name=name)

# Конвертация в Markdown (без индекса строк)
md_table = df.to_markdown(index=False)

# Сохранение
with open(output_file, "w", encoding="utf-8") as f:
    f.write(md_table)