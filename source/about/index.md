---
layout: page
title: About theory.pm
comments: false
sharing: false
footer: true
---

{% img /images/theory.jpg David E. “Theory” Wheeler %}

My name is David E. Wheeler, and this is my Perl blog. I've been hacking Perl
since 1995, when I first started programming. Perl was my first language, and
still my favorite. Today I mostly hack on database-related code, including
[PGXN](http://pgxn.org/), a [CPAN](https://metacpan.org/)-like service for
[PostgreSQL](http://www.postgresql.org/), and [Sqitch](http://sqitch.org/),
a database schema change management app.

I'm [@theory on Twitter](https://twitter.com/theory/) and also
[@theory on App.Net](https://alpha.app.net/theory/).

You can hire me to hack Perl and PostgreSQL via my consulting firm,
[PostgreSQL Experts](http://pgexperts.com/).

Recent CPAN Releases
--------------------

<script type="text/javascript">
function dists(data) {
    document.write('<dl>');
    for (i in data.hits.hits) {
        var dist = data.hits.hits[i].fields;
        document.write(
            '<dt><a href="http://metacpan.org/release/DWHEELER/' + dist.name +
            '">' + dist.distribution + '</a></dt>' +
            '<dd>' + dist.abstract + '</dd>'
        );
    }
    document.write('</dl>');
}
 </script>
 
<script type="text/javascript"
         src="http://api.metacpan.org/v0/release/_search?q=author:DWHEELER+AND+status:latest&fields=name,distribution,abstract&size=10&sort=date:desc&callback=dists">
</script>

Contact Me
----------

<section class="vcard" itemtype="http://data-vocabulary.org/Person"><p></p>
<dl>
    <dt>Name:</dt>
    <dd itemprop="name">David E. Wheeler</dd>
    <dt>Email:</dt>
    <dd>david@justatheory.com</dd>
    <dt>Twitter:</dt>
    <dd itemprop="url"><a href="https://twitter.com/theory">@theory</a></dd>
    <dt>App.net:</dt>
    <dd itemprop="url"><a href="https://alpha.app.net/theory">@theory</a></dd>
    <dt>GitHub:</dt>
    <dd itemprop="url"><a href="https://github.com/theory">@theory</a></dd>
    <dt>CPAN:</dt>
    <dd itemprop="url"><a href="https://metacpan.org/author/DWHEELER">@dwheeler</a></dd>
</dl>
</section>

About this Blog
---------------

This blog is built and published with [Octopress](http://octopress.org/) and
written in [Markdown](http://daringfireball.net/projects/markdown/). You can
[subscribe to the feed](/atom.xml) if that's your thing.

The visual style of this blog is a modified version of
[Aron Cedercrantz’s BlogTheme](https://github.com/rastersize/BlogTheme), the
license for which can be
[found here](https://github.com/rastersize/BlogTheme/blob/master/LICENSE).

