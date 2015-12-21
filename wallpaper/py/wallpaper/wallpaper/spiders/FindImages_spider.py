__author__ = 'marquis'

import json
import re

from scrapy.spiders import Spider
from wallpaper.items import WallpaperItem


class FindImagesSpider(Spider):
    name = "FindImages"
    allowed_domains = ['himawari8.nict.go.jp']
    start_urls = ['http://himawari8.nict.go.jp/img/D531106/latest.json']

    def parse(self, response):
        sites = json.loads(response.body_as_unicode().encode('utf8'))
        date_ = sites['date']
        # get date
        pattern = re.compile(r'(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)')
        result = re.search(pattern, date_)
        if result:
            year = result.group(1)
            month = result.group(2)
            day = result.group(3)
            hour = result.group(4)
            minute = result.group(5)
            second = result.group(6)
        else:
            pass
        img = "http://res.cloudinary.com/dajkskdsp/image/upload/%s_%s_%s_%s_%s_%s_earth_live_photo_vps.png" \
            % (year, month, day, hour, minute, second)
        items = []
        item = WallpaperItem()
        item['image_urls'] = [img]
        # the name information for your image
        item['image_name'] = [hour+minute+second+'_0_0']
        items.append(item)
        return items
