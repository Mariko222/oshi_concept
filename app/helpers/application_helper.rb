module ApplicationHelper
  def default_meta_tags
    {
      site: '推し概念集めてみた',
      title: '推し概念集めてみた',
      description: '推しのイメージと感じたもの(概念）を好きなだけ集めてオリジナルのマイページを作成できます',
      keywords: '推し, 概念, キャラ, キャラクター, アイドル, 概念コスメ, 概念コーデ, イメージ',
      noindex: !Rails.env.production?,
      canonical: request.original_url,
      reverse: true,
      charset: 'UTF-8',
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('apple-touch-icon.png'), rel: 'apple-touch-icon' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        creator: '@momo95843',
        card: 'summary_large_image',
        image: image_url('ogp.png')
      }
    }
  end
end
