FROM cloudgear/ruby:2.2-onbuild
MAINTAINER Georg Kunz <contact@cloudgear.net>

EXPOSE 3000

CMD ["bundle", "exec", "unicorn", "-c", "unicorn.rb", "-p", "3000"]
