---
layout: post
title: "Trying Times"
date: 2013-07-26 15:20
comments: true
published: true
categories: [exceptions]
---

Exception handling is a bit of a pain in Perl. Traditionally, we use
`eval {}`:

``` perl Perl eval
eval {
    foo();
}
if (my $err = $@) {
    # Inspect $err…
}
```

The use of the `if` block is a bit unfortunate; worse is the use of the global
`$@` variable, which has inflicted unwarranted pain on developers over the
years[^1]. Many Perl hackers put [Try::Tiny] to work to circumvent these
shortcomings:

``` perl Try::Tiny
try {
    foo();
} catch {
    # Inspect $_…
};
```

Alas, Try::Tiny introduces its own idiosyncrasies, particularly its use of
subroutine references rather than blocks. While a necessity of a pure-Perl
implementation, it prevents `return`ing from the calling context. One must
work around this deficiency by [checking return values]:

``` perl Return from Try::Tiny http://stackoverflow.com/a/10366209/79202 More Gotchas
my $rv = try {
   f();
} catch {
   # …
};

if (!$rv) {
   return;
}
```

I can't tell you how often this quirk burns me.

<div id='networkedblogs_nwidget_container' style='height:360px;padding-top:10px;'><div id='networkedblogs_nwidget_above'></div><div id='networkedblogs_nwidget_widget' style="border:1px solid #D1D7DF;background-color:#F5F6F9;margin:0px auto;"><div id="networkedblogs_nwidget_logo" style="padding:1px;margin:0px;background-color:#edeff4;text-align:center;height:21px;"><a href="http://www.networkedblogs.com/" target="_blank" title="NetworkedBlogs"><img style="border: none;" src="http://static.networkedblogs.com/static/images/logo_small.png" title="NetworkedBlogs"/></a></div><div id="networkedblogs_nwidget_body" style="text-align: center;"></div><div id="networkedblogs_nwidget_follow" style="padding:5px;"><a style="display:block;line-height:100%;width:90px;margin:0px auto;padding:4px 8px;text-align:center;background-color:#3b5998;border:1pxsolid #D9DFEA;border-bottom-color:#0e1f5b;border-right-color:#0e1f5b;color:#FFFFFF;font-family:'lucida grande',tahoma,verdana,arial,sans-serif;font-size:11px;text-decoration:none;" href="http://www.networkedblogs.com/blog/theorypm" id="ebac8e75be42e2bc9b4b710e6436008d">Follow this blog</a></div></div><div id='networkedblogs_nwidget_below'></div></div><script type="text/javascript">
if(typeof(networkedblogs)=="undefined"){networkedblogs={};networkedblogs.blogId=1391106;networkedblogs.shortName="theorypm";}
</script><script src="http://nwidget.networkedblogs.com/getnetworkwidget?bid=1391106" type="text/javascript"></script>


<!-- more -->

Sadly, there is a deeper problem then syntax: Just what, exactly, is an
exception? How does one determine the exceptional condition, and what can be
done about it? It might be a string. The string might be localized. It might
be an [Exception::Class] object, or a [Throwable] object, or a simple array
reference. Or any other value a Perl scalar can hold. This lack of specificity
requires careful handling of exceptions:

``` perl Exceptional Conditions
if (my $err = $@) {
    if (ref $err) {
        if (eval { $err->isa('Exception::Class') }) {
            if ( $err->isa('SomeException') ) {
                # …
            } elsif ( $err->isa('SomeException') ) {
                # …
            } else {
                # …
            }
        } elsif (eval { $err->DOES('Throwable') }) {
            # …
        } elsif ( ref $err eq 'ARRAY') {
            # …
        }
    } else {
        if ( $err =~ /DBI/ ) {
            # …
        } elsif ( $err =~ /cannot open '([^']+)'/ ) {
            # …
        }
    }
}

```

Not every exception handler requires so many conditions, but I have certainly
exercised all these approaches. Usually my exception handlers accrete
condition as users report new, unexpected errors.

That's not all. My code frequently requires parsing information out of a
string error. Here's an example from [PGXN::Manager]:

``` perl Exception Parsing https://github.com/pgxn/pgxn-manager/blob/master/lib/PGXN/Manager/Distribution.pm#L123 Source
try {
    $self->distmeta(decode_json scalar $member->contents );
} catch {
    my $f = quotemeta __FILE__;
    (my $err = $_) =~ s/\s+at\s+$f.+//ms;
    $self->error([
        'Cannot parse JSON from “[_1]”: [_2]',
        $member->fileName,
        $err
    ]);
    return;
} or return;

return $self;
```

When [JSON] throws an exception on invalid JSON, the code must catch that
exception to show the user. The user cares not at all what file threw the
exception, nor the line number. The code must *strip that stuff out* before
passing the original message off to a localizing error method.

Gross.

It's time to end this. A forthcoming post will propose a plan for adding
proper exception handling to the core Perl language, including exception
objects and an official `try`/`catch` syntax.

<!-- notes -->

[^1]: In fairness much of the `$@` pain has been addressed [in Perl 5.14].
[Try::Tiny]: https://metacpan.org/module/Try::Tiny
[checking return values]: http://stackoverflow.com/a/10366209/79202
[Exception::Class]: https://metacpan.org/module/Exception::Class
[Throwable]: https://metacpan.org/module/Throwable
[PGXN::Manager]: https://github.com/pgxn/pgxn-manager/
[JSON]: https://metacpan.org/module/JSON
[in Perl 5.14]: https://metacpan.org/module/JESSE/perl-5.14.0/pod/perldelta.pod#Exception-Handling

