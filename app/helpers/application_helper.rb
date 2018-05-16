# このヘルパーは自動的にrailsに読み込まれる。呼ぶ側でincludeは不要
module ApplicationHelper

  # ページごとの完全なタイトルを返す
  # デフォルト値は''
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
