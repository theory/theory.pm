---
layout: page
title: About theory.pm
comments: false
sharing: false
footer: true
---

{% img left /images/theory.jpg 400 400 David E. “Theory” Wheeler %}

Hi, I'm David E. Wheeler, a.k.a. "theory", a.k.a.
[DWHEELER](https://metacpan.org/author/DWHEELER "DWHEELER's CPAN Distributions")
on CPAN. I've been hacking Perl since 1995, when I first started programming.
Perl was my first language, and still my favorite. [theory.pm](/) is my Perl
blog. I also have a [personal blog](http://justatheory.com/ "Just a Theory").

Recent CPAN Releases
--------------------

<script type="text/javascript">
function dists(data) {
    document.write('<dl>');
    for (i in data.hits.hits) {
        var dist = data.hits.hits[i].fields;
        document.write(
            '<dt><a href="http://metacpan.org/release/DWHEELER/' + dist.name +
            '">' + dist["metadata.name"] + '</a></dt>' +
            '<dd>' + dist["metadata.abstract"] + '</dd>'
        );
    }
    document.write('</dl>');
}
 </script>
 
<script type="text/javascript"
         src="http://api.metacpan.org/v0/release/_search?q=author:DWHEELER+AND+status:latest;fields=name,metadata.name,metadata.abstract;size=10;sort=date:desc;callback=dists">
</script>
