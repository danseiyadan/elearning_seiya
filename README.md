# E-learning App 概要

URL: https://els-seiya2.herokuapp.com/

このサイトは単語勉強を目的としたeラーニングのサンプルアプリケーションです。

全ての機能を使用するには、以下の情報を使ってログインしてください。

・Email: admin@email.com

・Password: password

このアプリケーションは、プログラミングスクールKredoのRuby on Railsコースにて作成したものを改良したものです。

# 使用技術

・Ruby 3.0.3

・Ruby on Rails 6.0.4

・MySQL 5.7

・Docker/Docker-compose

# 機能一覧
・ユーザー登録、ログイン機能(devise不使用)

　→管理者ユーザーと一般ユーザーの二種類が存在

　→管理者ユーザーのみレッスンの作成とユーザー管理が可能
・レッスン作成機能

・レッスン受講機能

・フォロー機能（Ajax）

・ページネーション機能(will_paginate)