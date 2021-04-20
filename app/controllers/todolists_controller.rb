class TodolistsController < ApplicationController
  def new
    @list = List.new
    # 投稿を新規作成するには、「空のモデル」をform_withの引数に渡す必要がある。
    # 「List.new」と記述すると、空のモデルが生成され、インスタンス変数@listに代入されてViewで利用できるようになります。
  end

  def create
    # １. データを新規登録するためのインスタンス作成
    list = List.new(list_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    list.save
    # ３. トップ画面へリダイレクト
    redirect_to todolist_path(list.id)
    # showアクションにリダイレクトさせるには、名前付きルートを使用して、redirect_to todolist_path(list.id)
    # todolist_pathを引数と呼び、引数には必ずidが必要になります。
  end
  # ここで、createアクション内の変数（list）に@がないことを不思議に感じるかもしれませんね。
  # @のついたインスタンス変数とローカル変数の違いについて、@のついているインスタンス変数はビューファイルへ受け渡すことができ、
  # 一方でローカル変数は、ビューファイルに受け渡しができません。

  def index
    @lists = List.all
    # このインスタンス変数にはすべてのデータが取り出されて格納されるため、インスタンス変数名を複数形
  end

  def show
    @list = List.find(params[:id])
    # URLの/todolists/:id内の:idは、アクション内にparams[:id]と記述することで取得できます。
    # 今回はレコード1件を取得するので、インスタンス変数名は単数形の「@list」
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to todolist_path(list.id)
  end

  def destroy
    list = List.find(params[:id])
    # データ（レコード）を1件取得
    list.destroy
    redirect_to todolists_path
    # 一覧画面を指すtodolists_path（indexアクション）に設定
  end






  private
  def list_params
    # list_paramsではフォームで入力されたデータを受け取っています。
    params.require(:list).permit(:title, :body, :image)
    # paramsはRailsで送られてきた値を受け取るためのメソッド
    # requireで(:モデル名)ここでは:list)を指定し、
    # permitでキー（:title,:body）を指定しています。
  end
end
