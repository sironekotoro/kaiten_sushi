#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

# 寿司を回転させる角度を保存するスカラー変数
my $angle = 0;

get '/' => sub {
  my $c = shift;
  # コントローラ部のスカラー変数 $angle を
  # テンプレート部のスカラー変数 $kakudo に
  # stashを使って渡す
  $c->stash(kakudo => $angle);
  $c->render(template => 'index');
};

get '/kaiten' => sub {
  my $c = shift;

  # /kaiten にアクセスする都度、回転角度を30度増やす
  $angle = $angle + 30;

  # 上部の / と同じ処理
  $c->stash(kakudo => $angle);
  $c->render(template => 'index');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<h1>寿司を回す</h1>

<!-- タグの表示を制御するスタイルシートを直接設定しています -->
<img src='sushi_ootoro.png' alt='いらすとやさんの大トロ寿司！' style="transform:rotate(<%= $kakudo %>deg);" />

<form action="/kaiten">
  <button type="submit">回す！</button>
</form>

<hr>

<h2>デバッグ</h2>
<!--
ビュー部はHTMLなのでコメントもHTML形式のものを使う
コントローラ部で設定し、引き渡された変数 $kakudo を
表示する
-->
<p>現在の角度：<%= $kakudo %></p>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
