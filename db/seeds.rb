# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
tag1 = Tag.new(
  tag: 'thien_nhien'
)
picture_url1 = ["http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-1-1024x576.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-2-1024x640.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-3-1024x640.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-4-1024x640.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-5-1024x576.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-6-1024x640.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-7-1024x640.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-8-1024x640.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-9-1024x640.jpg",
               "http://tapchianhdep.com/wp-content/uploads/2015/08/tai-hinh-nen-phong-canh-mua-thu-dep-nhat-2015-10-1024x640.jpg"
              ]
tag1.pictures << picture_url1.map{
  |e| _pic = Picture.new(url: e)
}
tag1.save

tag2 = Tag.new(
  tag: 'desktop'
)
picture_url2 = ["https://lh3.googleusercontent.com/knPlFVZhNT7hO3-YuldK20SLbSuew_eWp8mB2j6SpPk=w1186-h667-no",
                "https://lh3.googleusercontent.com/YahkNtuu7Z1BNp75g_9cknDtKvjSpsWx3TGsI_IBfnw=w1186-h667-no",
                "https://lh3.googleusercontent.com/AEDa7_FfyW4SqEUd9MSut_FyPFRv0BrBjiCNQgY3VNU=w1186-h667-no",
                "https://lh3.googleusercontent.com/NNHFVtk-7yzLDlJrQXtuUTRNkD_8jFG7x_THhNo2Ick=w1186-h667-no",
                "https://lh3.googleusercontent.com/9kQGAPJxqMMXhKanxE9g1WK5N52LTpwwIyP30mDF56A=w1186-h667-no",
                "https://lh3.googleusercontent.com/a4dZnCI3joJApPuZ7zk-hf17BqNveKZFGiFRpjhgTQ4=w1186-h667-no",
                "https://lh3.googleusercontent.com/6z56F_1bx8BzHGH-9h4S3pWaS05r9VD1h7ww5EcliGU=w1186-h667-no",
                "https://lh3.googleusercontent.com/r7pEKjqbfVNzH7cl-Gs1Pq8w1uHHxSOaMNysUo7Dzxc=w1187-h667-no",
                "https://lh3.googleusercontent.com/6Ae2u9k9sWZfV93KxQIvOhqcLMoCgzEb2ktuHbW_LDE=w1186-h667-no",
                "https://lh3.googleusercontent.com/ZqrtZJLKd53wVkgbpVDwQaR5VKoymy9aqErOsJaTFr4=w1186-h667-no",
                "https://lh3.googleusercontent.com/orrA2aX7M3ZMXQSB4TcdE1zm58rgn9aZwvpK_asZ6nc=w1186-h667-no",
                "https://lh3.googleusercontent.com/Okan2KeRF31_79eR567Hjf_Oxv4kYK7qEUhzPwGJkJQ=w1186-h667-no",
                "https://lh3.googleusercontent.com/grRXAcWsT4XOjxpGROVztarsHf5GFmJU3H3YKe9b2R0=w1186-h667-no",
                "https://lh3.googleusercontent.com/GPBJ6xQskKoubjRIvMbveAHHnFYgqfLtppSVq_DiX14=w1186-h667-no"
               ]
tag2.pictures << picture_url2.map{
  |e| _pic = Picture.new(url: e)
}
tag2.save
