# SML#で始める実践MLプログラミング 正誤表

下記の誤りがありました。お詫びして訂正いたします。

本ページに掲載されていない誤りを見つけられた方は、[GitHubのIssues]でお知らせください。

[GitHubのIssues]: https://github.com/smlsharp/mlpractice-book/issues

## 初版1刷

<table>
<thead>
<tr><th>該当箇所</th><th>誤</th><th>正</th></tr>
</thead>
<tbody>

<tr>
<td>2章 p.35 下から4行目</td>
<td>
<pre>
val name = fn : ['a#{name: 'b}. 'b, 'a -> 'b]
</pre>
</td>
<td>
<pre>
val name = fn : ['a#{name: 'b}<strong>,</strong> 'b<strong>.</strong> 'a -> 'b]
</pre>
</td>
</tr>

<tr>
<td>2章 p.38 21行目</td>
<td>
<pre>
$ smlsharp -MMm main.smi &gt; Makefile
$ make
smlsharp -O2 -o FunctionTest.o -c FunctionTest.sml
smlsharp -O2 -o main.o -c main.sml
smlsharp  -o main main.smi
$ time ./main
500000000500000000
</pre>
</td>
<td>
<pre>
$ smlsharp -MMm <strong>Main.smi</strong> &gt; Makefile
$ make
smlsharp -O2 -o FunctionTest.o -c FunctionTest.sml
smlsharp -O2 -o <strong>Main.o</strong> -c <strong>Main.sml</strong>
smlsharp  -o <strong>Main</strong> <strong>Main.smi</strong>
$ time <strong>./Main</strong>
500000000500000000
</pre>
</td>
</tr>

<tr>
<td>3章 p.51 図3.1 下から1行目</td>
<td>
<img src="https://render.githubusercontent.com/render/math?math=unzip(l)=L_{zip}(l,nil,nil)" alt="$unzip(l) = L_{zip}(l, nil, nil)$">
</td>
<td>
<img src="https://render.githubusercontent.com/render/math?math=unzip(l)=L_{unzip}(l,\mathrm{nil},\mathrm{nil})" alt="$unzip(l) = L_{unzip}(l, \mathtt{nil}, \mathtt{nil})$">
</td>
</tr>

<tr>
<td>3章 p.55 問3.1 3行目</td>
<td>
<p>
ソースファイル<code>ListFunctions.sml</code>とインターフェイスファイル<code>ListFunctions.sml</code>を作成してください。
</p>
</td>
<td>
<p>
ソースファイル<code>ListFunctions.sml</code>とインターフェイスファイル<code>ListFunctions.<strong>smi</strong></code>を作成してください。
</p>
</td>
</tr>

<tr>
<td>4章 p.65 問4.2 5行目</td>
<td>
<p>
ソースファイル<code>Tree.sml</code>とインターフェイスファイル<code>Tree.sml</code>を定義してください。
</p>
</td>
<td>
<p>
ソースファイル<code>Tree.sml</code>とインターフェイスファイル<code>Tree.<strong>smi</strong></code>を<strong>作成</strong>してください。
</p>
</td>
</tr>

</tbody>
</table>
