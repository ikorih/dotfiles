# 💤 LazyVim カスタム設定ドキュメント

このドキュメントは、LazyVimのカスタム設定、利用しているプラグイン、およびその使い方の完全なガイドです。

## 目次

- [基本情報](#基本情報)
- [キーマッピング](#キーマッピング)
- [プラグイン一覧と使用方法](#プラグイン一覧と使用方法)
- [言語サポート](#言語サポート)
- [その他の設定](#その他の設定)

---

## 基本情報

### ベース
- **LazyVim**: Neovim用のモダンで高速な設定フレームワーク
- **カラースキーム**: Gruvbox
- **パッケージマネージャー**: lazy.nvim

---

## キーマッピング

### 基本的なキーマッピング

#### モード切替
- `jk` or `jj` (挿入モード) → ノーマルモードに戻る

#### 削除
- `x` (ノーマルモード) → 文字を削除（ヤンクレジスタに保存しない）

#### タブ操作
- `te` → 新しいタブを開く
- `<Tab>` → Sidekick NESがあれば承認/ジャンプ、複数タブがあれば次のタブに移動
- `<Shift-Tab>` → 複数タブがあれば前のタブに移動
- `<leader><tab><tab>` → 新しいタブを作成
- `<leader><tab>d` → タブを閉じる
- `<leader><tab>]` → 次のタブ
- `<leader><tab>[` → 前のタブ

#### ファイル検索
- `<C-t>` → ファイル検索（`<leader>ff`と同じ動作、fzf-luaを使用）

### Copilot & Sidekick キーマッピング

#### インサートモードでの提案（Copilot）
- `<C-y>` → **Copilotの提案を承認（インサートモード）**
- `<M-w>` (Alt/Option + w) → 単語単位で提案を承認
- `<M-l>` (Alt/Option + l) → 行単位で提案を承認
- `<M-]>` (Alt/Option + ]) → 次の提案を表示
- `<M-[>` (Alt/Option + [) → 前の提案を表示
- `<C-]>` → 提案を閉じる

#### ノーマルモードでの提案（Sidekick NES）
**重要: ノーマルモードでの黄色いサジェスト（Next Edit Suggestions）の操作**

- `<Tab>` → **NESを承認/次の編集箇所にジャンプ**
  - サジェストがある場合、最初の`<Tab>`で次の変更箇所にジャンプ
  - 全ての変更箇所を確認した後、もう一度`<Tab>`で全体を承認
  - NESがない場合は通常のタブ移動として動作
- `<leader>uN` → NESの有効/無効を切り替え

**注意**: `<Tab>`キーはNESがある時だけSidekickの機能として動作し、ない時は通常のタブ移動（`:tabnext`）として機能します。

#### AI CLI（Sidekick）
- `<C-.>` → Sidekick AI CLIのトグル（全モード対応）
- `<leader>aa` → Sidekick CLIを開く
- `<leader>as` → AI CLIツールを選択
- `<leader>ad` → CLIセッションを切断
- `<leader>at` → カーソル位置のコードをAIに送信
- `<leader>af` → ファイル全体をAIに送信
- `<leader>av` → 選択範囲をAIに送信（ビジュアルモード）
- `<leader>ap` → プロンプトを選択

### LazyVimデフォルトキーマッピング

LazyVimには多くのデフォルトキーマッピングが含まれています。主なものは以下の通りです：

#### リーダーキー
- リーダーキーは `<Space>` (スペースキー) です

#### ファイル操作
- `<leader>ff` → ファイルを検索
- `<leader>fg` → Grepで検索
- `<leader>fb` → バッファ一覧
- `<leader>fr` → 最近使用したファイル
- `<leader>fe` → ファイルエクスプローラー（Neo-tree）を開く

#### LSP関連
- `gd` → 定義へジャンプ
- `gr` → 参照を表示
- `K` → ホバー情報を表示
- `<leader>ca` → コードアクション
- `<leader>cr` → リネーム

#### Git操作
- `<leader>gg` → LazyGitを開く
- `<leader>gb` → Git blame

---

## プラグイン一覧と使用方法

### 1. GitHub Copilot & Sidekick

#### Copilot (zbirenbaum/copilot.lua)

**概要**: AIによるインラインコード補完プラグイン

**設定**:
- 自動トリガー有効
- ゴーストテキストによる提案表示（グレーで表示）

**使い方**:
- **インサートモード**でコーディング中に自動的に提案が表示されます
- `<C-y>`で提案を承認
- 詳細は上記の「Copilot & Sidekick キーマッピング」セクションを参照

#### Sidekick NES (folke/sidekick.nvim)

**概要**: Copilot LSPのNext Edit Suggestions（大規模な編集提案）

**特徴**:
- **ノーマルモード**で複数行や大規模なリファクタリング提案を表示
- 黄色（または強調色）でサジェストを表示
- Tree-sitterベースの詳細な差分表示
- 変更箇所ごとに確認してから適用可能

**使い方**:
1. コードを編集してカーソルを移動すると、自動的にNESが取得されます
2. 黄色で強調表示されたサジェストが表示されたら、`<Tab>`キーを押す
3. 複数の変更箇所がある場合、`<Tab>`で次の箇所にジャンプして確認
4. 全て確認したら、もう一度`<Tab>`で全体を適用

**NESとインライン補完の違い**:
- **インライン補完（Copilot）**: 現在のカーソル位置から続くコードの提案（グレー表示）
- **NES（Sidekick）**: ファイル全体の大規模な変更やリファクタリング提案（黄色表示）

#### AI CLI統合

**概要**: ターミナル内でAI CLIツールと対話

**サポートツール**:
- Claude
- Gemini
- Grok
- Copilot CLI
- その他のAI CLIツール

**使い方**:
- `<leader>aa`でCLIを開く
- `<leader>as`でツールを選択
- コードの説明、バグ修正、テスト作成などのプロンプトを使用可能

### 2. Blink.cmp (saghen/blink.cmp)

**概要**: 高速な補完エンジン

**設定**:
- デフォルトプリセットを使用
- Copilotと統合されており、`<C-y>`で両方を制御可能

**使い方**:
- 入力中に自動的に補完候補が表示されます
- `<Tab>`で次の候補、`<Shift-Tab>`で前の候補
- `<CR>`（Enter）で選択を確定

### 3. Emmet (mattn/emmet-vim)

**概要**: HTMLとCSSの高速コーディング支援

**キーマッピング**:
- `<C-e>,` → Emmet展開を実行

**使用例**:
```html
<!-- 入力: div.container>ul>li*3 -->
<!-- <C-e>, を押すと展開 -->
<div class="container">
  <ul>
    <li></li>
    <li></li>
    <li></li>
  </ul>
</div>
```

**設定**:
- PHPファイルでもHTML構文を使用可能

### 4. vim-expand-region (terryma/vim-expand-region)

**概要**: ビジュアルモードで選択範囲を動的に拡大・縮小

**使い方**:
1. ビジュアルモード（`v`）で選択を開始
2. `v`キーを押すごとに選択範囲が拡大（単語→括弧→段落など）
3. `V`（Shift+v）で選択範囲を縮小

**対象テキストオブジェクト**:
- `iw`: 単語内
- `i"`, `i'`: 引用符内
- `i]`, `ib`, `iB`: 括弧内
- `ip`: 段落

### 5. mini.align (nvim-mini/mini.align)

**概要**: テキスト整列プラグイン

**キーマッピング**:
- `ga` → 指定した文字で整列
- `gA` → 詳細設定で整列

**使用例**:
```
// 整列前
let x = 1
let longVariableName = 2

// gaを押して=を指定すると整列後
let x                = 1
let longVariableName = 2
```

### 6. mini.ai (nvim-mini/mini.ai)

**概要**: テキストオブジェクトの拡張

**使い方**:
- Vimの標準テキストオブジェクトを強化
- `diw`: 単語を削除
- `ci"`: 引用符内を変更
- `va(`: 括弧とその内容を選択

### 7. Neo-tree (nvim-neo-tree/neo-tree.nvim)

**概要**: ファイルエクスプローラー

**キーマッピング**:
- `<leader>fe` → Neo-treeを開く（ルートディレクトリ）
- `<leader>fE` → Neo-treeを開く（カレントディレクトリ）

**Neo-tree内での操作**:
- `o` → ファイルを開く
- `a` → ファイル/ディレクトリを追加
- `d` → 削除
- `r` → リネーム
- `y` → コピー
- `x` → カット
- `p` → ペースト

**設定**:
- 隠しファイル（dotfiles）を表示
- .gitignoreファイルも表示

### 8. ts-comments (folke/ts-comments.nvim)

**概要**: Tree-sitterベースのスマートコメント

**使い方**:
- `gcc` → 現在行をコメント/アンコメント
- `gc` (ビジュアルモード) → 選択範囲をコメント/アンコメント
- `gcip` → 段落をコメント

**カスタム設定**:
- SCSSファイルではブロックコメント（`/* */`）を使用

### 9. Tailwind CSS関連

#### nvim-colorizer.lua
**概要**: カラーコードの視覚化

**機能**:
- Tailwindクラスの色をエディタ内で表示
- カラーコード（#fff, rgb()など）をハイライト

#### tailwindcss-colorizer-cmp
**概要**: 補完メニューでTailwindの色を表示

**機能**:
- 補完候補にTailwindクラスの実際の色を表示

### 10. Tree-sitter (nvim-treesitter/nvim-treesitter)

**概要**: 高度な構文解析とハイライト

**機能**:
- 正確なシンタックスハイライト
- コード構造の理解
- テキストオブジェクトの強化

**設定**:
- mainブランチを使用
- 自動更新（`:TSUpdate`）

---

## 言語サポート

以下の言語に対するサポートが有効化されています：

### TypeScript/JavaScript
- **LSP**: TypeScript Language Server
- **フォーマッター**: Prettier
- **リンター**: ESLint

### Vue.js
- Vue 3対応
- TypeScriptサポート

### JSON
- スキーマ検証
- フォーマット

### YAML
- 構文チェック
- フォーマット

### Docker
- Dockerfile構文サポート

### Rust
- rust-analyzer（LSP）
- フォーマット、リント

### Markdown
- プレビュー機能
- 構文ハイライト
- Tree-sitter統合

### Tailwind CSS
- クラス名補完
- カラープレビュー

---

## その他の設定

### オプション設定

#### 行の折り返し
```lua
vim.opt.wrap = true  -- 長い行を折り返して表示
```

#### Conceallevel
- JSONとMarkdownファイルでは文字を隠さない（conceallevel = 0）

#### ファイルタイプ
- `.njk`と`.hbs`ファイルをHTMLとして扱う

#### アニメーション
- Snacksアニメーションは無効化

### オートコマンド

#### Markdownと MDX
- Tree-sitterによる構文解析を有効化

### フォーマッター設定

#### Prettier
- 設定ファイルが必要（`lazyvim_prettier_needs_config = true`）
- プロジェクトに`.prettierrc`がない場合は動作しません

#### ESLint
- 保存時に自動フォーマット有効（`lazyvim_eslint_auto_format = true`）

---

## LazyVim Extras

以下のLazyVim extrasが有効化されています：

### UI
- **alpha**: スタート画面
- **mini-hipatterns**: パターンハイライト

### Editor
- **mini-diff**: Git差分表示
- **mini-files**: ファイル操作

### AI
- **sidekick**: Copilot LSPのNext Edit Suggestions統合とAI CLI
- **copilot**: GitHub Copilot統合（インライン補完）

### Coding
- **mini-surround**: テキストの囲み操作
- **blink**: 高速補完

### Linting & Formatting
- **eslint**: JavaScript/TypeScript linting
- **prettier**: コードフォーマット

---

## よく使うコマンド

### Lazy.nvim管理
- `:Lazy` → プラグイン管理画面を開く
- `:Lazy update` → プラグインを更新
- `:Lazy sync` → プラグインを同期

### Mason（LSP/ツール管理）
- `:Mason` → Mason UIを開く
- `:MasonInstall <tool>` → ツールをインストール

### LSP
- `:LspInfo` → LSP情報を表示
- `:LspRestart` → LSPを再起動

### Tree-sitter
- `:TSUpdate` → パーサーを更新
- `:TSInstall <lang>` → 言語パーサーをインストール

### その他
- `:checkhealth` → Neovimの健全性チェック

---

## トラブルシューティング

### Copilotの提案が表示されない

#### インライン補完（グレー表示）
1. `:Copilot status` でステータスを確認
2. `:Copilot auth` で認証
3. Neovimを再起動

#### NES提案（黄色表示）
1. `:checkhealth sidekick` でSidekickの状態を確認
2. `:LspInfo` でCopilot LSPが起動しているか確認
3. `:LspCopilotSignIn` でサインイン（必要な場合）
4. `<leader>uN` でNESの有効/無効を切り替えて確認

### LSPが動作しない
1. `:LspInfo` で状態を確認
2. `:Mason` で必要なLSPがインストールされているか確認
3. `:LspRestart` でLSPを再起動

### プラグインが読み込まれない
1. `:Lazy` でプラグイン状態を確認
2. `:Lazy sync` で同期
3. エラーメッセージを確認

---

## 参考リンク

- [LazyVim公式ドキュメント](https://lazyvim.github.io/)
- [Neovim公式ドキュメント](https://neovim.io/doc/)
- [GitHub Copilot](https://github.com/features/copilot)

---

## カスタマイズのヒント

設定をカスタマイズする際は、以下のファイルを編集してください：

- **キーマッピング**: `lua/config/keymaps.lua`
- **オプション**: `lua/config/options.lua`
- **オートコマンド**: `lua/config/autocmds.lua`
- **プラグイン追加**: `lua/plugins/`ディレクトリに新しいファイルを作成

変更後は`:Lazy reload`で設定を再読み込みするか、Neovimを再起動してください。
