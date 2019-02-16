#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

# 寿司を回転させる角度を保存するスカラー変数
my $angle = 0;

get '/' => sub {
  my $c = shift;
  $c->stash(kakudo => $angle);
  $c->render(template => 'index');
};

get '/kaiten' => sub {
  my $c = shift;
  $c->stash(kakudo => $angle);
  $c->render(template => 'index');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<h1>寿司を回す</h1>

<img src='sushi_ootoro.png' alt='いらすとやさんの大トロ寿司！' />

<form action="/kaiten">
  <button type="submit">回す！</button>
</form>

<hr>

<h2>デバッグ</h2>
<p>現在の角度：<%= $kakudo %></p>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
