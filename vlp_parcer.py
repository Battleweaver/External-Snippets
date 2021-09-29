import requests


def filter_posts():
    # Создайте standalone app на сайте https://vk.com/apps?act=manage и получите Сервисный Ключ Доступа (Настройки)
    token = "03147ed203147ed203147ed212036dfe160031403147ed262472a91a25bc8a3cde06585"
    version = 5.131
    # это домен сообщества Всего Лишь Писатель
    domain = "diewelle0"

    count = 100
    offset = 0
    # signer_id можете узнать из ссылки на любой пост автора на стене
    # Например, вот отсюда https://vk.com/lillamy382?w=wall208244200_4810 я вытаскиваю signer_id 208244200
    author_signer_id = 208244200
    result = {}

    # Просмотр 5000 постов охватывает примерно 2 года.
    while offset < 5000:
        response = requests.get("https://api.vk.com/method/wall.get",
                                params={
                                    "access_token": token,
                                    "v": version,
                                    "domain": domain,
                                    'offset': offset,
                                    'count': count
                                })
        data = response.json().get('response').get('items')

        for item in data:
            if item.get('signer_id') == author_signer_id:
                result[item.get('id')] = item.get('text')
                print(item.get('id'))
        offset += 100
    return result


result = filter_posts()
