module ApplicationHelper
  def daisyui_class_for(flash_type)
    case flash_type.to_sym
    when :success
      "alert alert-success"
    when :danger
      "alert alert-error"
    else
      "alert alert-info"
    end
  end

  def default_meta_tags
    {
      site: 'Yubimoji',
      title: 'ゆびもじ学習アプリ',
      reverse: true,
      charset: 'utf-8',
      description: 'ゆびもじアプリなら、好きな言葉を指文字に変換しながら学べます。あなたもこの新しい学び方を試してみませんか？',
      keywords: '手話,手話学習,指文字,ゆびもじ,コミュニケーション',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: 'Yubimoji',
        title: 'ゆびもじ学習アプリ',
        description: 'ゆびもじアプリなら、好きな言葉を指文字に変換しながら学べます。あなたもこの新しい学び方を試してみませんか？',
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'), # ここで使用するOGP画像のパスに変更してください
        locale: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '#', # 公式Twitterアカウントがあれば、アカウント名を入力
        image: image_url('ogp.png') # ここで使用するOGP画像のパスに変更してください
      }
    }
  end
end
