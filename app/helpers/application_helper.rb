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
      description: 'Yubimojiを使えば、ゆびもじを簡単に学ぶことができます。手話の指文字を使ってコミュニケーションの幅を広げましょう。',
      keywords: '手話,手話学習,指文字,ゆびもじ,コミュニケーション',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: 'Yubimoji',
        title: 'ゆびもじ学習アプリ',
        description: 'Yubimojiを使えば、指文字を簡単に学ぶことができます。好きな言葉を指文字に変えて学びましょう。',
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
