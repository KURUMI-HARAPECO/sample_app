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
    redirect_to '/top'
  end
  # ここで、createアクション内の変数（list）に@がないことを不思議に感じるかもしれませんね。
  # @のついたインスタンス変数とローカル変数の違いについて、@のついているインスタンス変数はビューファイルへ受け渡すことができ、
  # 一方でローカル変数は、ビューファイルに受け渡しができません。

  private
  def list_params
    # list_paramsではフォームで入力されたデータを受け取っています。
    params.require(:list).permit(:title, :body)
    # paramsはRailsで送られてきた値を受け取るためのメソッド
    # requireで(:モデル名)ここでは:list)を指定し、
    # permitでキー（:title,:body）を指定しています。
  end
end
