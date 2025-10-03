# Calculator (Lex & Yacc)

本專案是一個使用 **Flex (Lex)** 與 **Bison (Yacc)** 建立的簡易直譯式計算器，支援基本數學運算、函式運算、變數儲存與遞增/遞減操作。

## 功能特色
- **基本四則運算**：`+ - * /`
- **進階運算**：取餘數 `%`、次方 `^`
- **數學函式**：
  - `abs(x)`：絕對值
  - `sin(x)`：正弦
  - `cos(x)`：餘弦
  - `log(x)`：以 10 為底對數
  - `neg(x)`：取負
- **變數儲存與使用**：
  - `x = 5` → 定義變數
  - 使用變數時會檢查是否已定義，否則輸出錯誤
- **遞增與遞減運算子**：
  - 後置：`x++`、`x--`
  - 前置：`++x`、`--x`
- **錯誤處理**：
  - 未定義變數存取提示
  - 無效字元輸入時會顯示所在行數與錯誤字元

## 環境需求
- Linux / WSL (建議)
- **Flex** 與 **Bison**
- **g++ (C++17 以上)**

安裝 (Ubuntu/Debian)：
```bash
sudo apt-get install flex bison g++
```

## 編譯與執行

1. 產生語法分析器：

   ```bash
   bison -d calc.y
   ```

   會生成：

   * `calc.tab.c`
   * `calc.tab.h`

2. 產生詞法分析器：

   ```bash
   flex calc.l
   ```

   會生成：

   * `lex.yy.c`

3. 編譯：

   ```bash
   g++ -std=c++17 -o calc lex.yy.c calc.tab.c -lfl -lm
   ```

4. 執行：

   ```bash
   ./calc
   ```

## 使用範例

```text
x = 5
5.000000
x + 3
8.000000
sin(3.14159/2)
1.000000
x++
5.000000
x
6.000000
log(100)
2.000000
```

錯誤範例：

```text
y
Line 1: y is undefined
```

## 專案結構

```
├── calc.l        # Flex (Lex) 詞法分析器
├── calc.y        # Bison (Yacc) 語法分析器
├── calc.tab.c    # Bison 輸出 (自動生成)
├── calc.tab.h    # Bison 輸出 (自動生成)
├── lex.yy.c      # Flex 輸出 (自動生成)
└── calc          # 編譯後可執行檔
```

## 注意事項

* 變數名稱最長 255 字元。
* 數值型態為 `double`，但 `%` 取餘運算會強制轉型為整數。
* 錯誤會直接結束程式 (`exit`)。
* `line` 用來追蹤輸入行數，每次變數指派會遞增。

