# MiniCUIテストスクリプト - ファイルマネージャ風のUIデモ

# --- 初期化 ---
CLEAR
SET A 0   # 変数Aを0に設定（ループ制御用）
LIST LOAD L1 # カレントディレクトリの内容をリストL1に読み込む

# --- スプラッシュ画面 ---
# SPLASH "タイトル" "サブタイトル" 色 スリープ時間(ms)
SPLASH "MiniCUI DEMO" "File Browser Mockup" 44 2000

# --- メインループ ---
MAIN_LOOP:
    CLEAR
    
    # 画面描画
    COLOR 37
    BOX 1 1 80 24
    CENTER 1 "MiniCUI File List Demo"
    
    # リストL1の描画
    # LIST RENDER リスト名 X Y 高さ
    LIST RENDER L1 3 3 20
    
    # カーソル位置の調整と制限
    CURSOR LIMIT L1 # カーソルをリストの範囲内に制限
    
    # 変数にカーソル位置のアイテムがディレクトリかどうかを取得
    GET ITEM_ISDIR L1 D # L1の現在のカーソル位置のアイテムがディレクトリならD=1、そうでなければD=0
    
    # 情報表示
    COLOR 33
    POS 50 3
    PRINT "Current Index: "
    POS 65 3
    PRINT A # Aは現在カーソル位置を保持
    
    COLOR 32
    POS 50 4
    PRINT "Is Directory: "
    POS 65 4
    IF D = 1 GOTO IS_DIR_MSG
    PRINT "No"
    GOTO END_MSG
IS_DIR_MSG:
    PRINT "Yes"
END_MSG:

    # 画面を更新
    POS 1 25
    COLOR 37
    PRINT "Up/Down: Move | q: Exit"
    
    # --- キー入力待ち ---
    KEYWAIT A # 押されたキーコードを変数Aに格納
    
    # --- キー入力処理 ---
    
    # qキー (113) で終了
    IF A = 113 GOTO EXIT_APP 
    
    # ↑キー (65) または k でカーソルを上に移動
    IF A = 65 CURSOR ADJ L1 -1
    IF A = 107 CURSOR ADJ L1 -1 # kキー
    
    # ↓キー (66) または j でカーソルを下に移動
    IF A = 66 CURSOR ADJ L1 1
    IF A = 106 CURSOR ADJ L1 1 # jキー
    
    GOTO MAIN_LOOP
    
# --- 終了 ---
EXIT_APP:
    CLEAR
    CENTER 12 "Goodbye!" 
    SLEEP 1000
    EXIT
