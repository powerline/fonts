OTB files were converted from BDFs file as discussed in [bug 1753295](https://bugzilla.redhat.com/show_bug.cig?id=1753295) using [fonttosfnt 1.2.1](https://gitlab.freedesktop.org/xorg/app/fonttosfnt/-/commit/33f944705c6c42e1b52f6ec62131d31f737c638f):
```
for f in *.bdf; do fonttosfnt -b -c -g 2 -m 2 -o ${f%.bdf}.otb $f; done
```

OTC files were created from OTB files via script [otf2otc.py](https://blogs.adobe.com/CCJKType/2014/01/otc.html):
```
python otf2otc.py -o ter-powerline-regular.otc ter-powerline-x*n.otb
python otf2otc.py -o ter-powerline-bold.otc ter-powerline-x*b.otb
```

Note that if you have `/etc/fonts/conf.d/71-enable-terminus.conf` and cannot see the fonts in `fc-list`, you can ether remove it or add this similar file `/etc/fonts/conf.d/71-enable-terminess.conf`:
```
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <selectfont>
    <acceptfont>
      <pattern>
        <patelt name="family"><string>Terminess Powerline</string></patelt>
        <patelt name="fontformat"><string>TrueType</string></patelt>
      </pattern>
    </acceptfont>
  </selectfont>
</fontconfig>
```
