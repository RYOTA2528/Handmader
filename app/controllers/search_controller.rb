class SearchController < ApplicationController
  def search
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @results = search_for(@how, @value)
  end

  private

  def match(value)
    PostItem.where(genre_id: value)
  end

  def search_for(how, value)
    case how                     #引数のhowと一致する処理に進むように定義しています。
    when 'match'                 #ジャンル検索の場合はmatchで固定してるので、必ず'match'の処理に進みます。
      match(value)
    end
  end

end
