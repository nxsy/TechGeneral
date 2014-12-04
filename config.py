config.register_asset(
    'main_css',
    'reset.css',
    'main.css',
    'pygment.css',
    output="cache_main.%(version)s.css")

config.context_update(
    name="TechGeneral",
    url="https://techgeneral.org",
    fb_app_id="664060780373796",
)

from feedgenerator.django.utils import feedgenerator
from flask import url_for

@app.route('/atom1.0')
def atom():
    feed = feedgenerator.Atom1Feed(
        title="TechGeneral",
        link="https://techgeneral.org/",
        description="by Neil Blakey-Milner",
        author_name="Neil Blakey-Milner",
        language="en",
        feed_url=url_for('atom', _external=True),
        ttl=60,
    )
    posts = [
        p for p in pages if 'published' in p.meta
        and p.meta.get('type', None) == 'post'
    ]
    for post in posts:
        print vars(post)
        feed.add_item(
            title=post.meta['title'],
            link=url_for('page', path=post.path, _external=True),
            description=post.meta['description'],
            pubdate=post.meta['date'],
            author_name="Neil Blakey-Milner",
        )
    return feed.writeString('utf-8')


