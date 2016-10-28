---
layout: blog

pageClass: page-type-post
---

<div class="trace">/ <a href="/myblog/blog/">{{ site.blog.name }}</a> / {{ page.title }}</div>

<article>
	<h1><a href="/myblog{{ page.url }}">{{ page.title }}</a></h1>
	{% assign post = page %}
	{% include meta.tpl %}
	{{ content }}
	{% capture permaurl %}http://{{site.blog.host}}{{ page.url }}{% endcapture %}
	<!--<p class="permalink">永久链接：<a href="{{ permaurl }}">{{ permaurl }}</a></p>-->
</article>

<!-- 多说评论框 start -->
<div class="ds-thread" data-thread-key="{{ page.url }}" data-title="{{ page.title }}" data-url="{{ page.url }}"></div>
<!-- 多说评论框 end -->
<!-- 多说公共JS代码 start (一个网页只需插入一次) -->
<script type="text/javascript">
var duoshuoQuery = {short_name:"wilsonis"};
	(function() {
		var ds = document.createElement('script');
		ds.type = 'text/javascript';ds.async = true;
		ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
		ds.charset = 'UTF-8';
		(document.getElementsByTagName('head')[0] 
		 || document.getElementsByTagName('body')[0]).appendChild(ds);
	})();
</script>
<!-- 多说公共JS代码 end -->


<!-- <div id="disqus_thread" class="comments"></div>
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-7231324007393765"
     data-ad-slot="7629180734"
     data-ad-format="auto"></ins>
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script> -->