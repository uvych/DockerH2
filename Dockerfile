FROM java:7

ENV H2DATA /h2-data
ENV RELEASE_DATE 2017-04-23

COPY h2 /h2/

RUN ln -s $(ls /h2/bin/*jar) /h2/bin/h2.jar \
&& mkdir /docker-entrypoint-initdb.d

COPY my-db-name.sql  /docker-entrypoint-initdb.d/

VOlUME /h2-data

EXPOSE 8082 9092

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD java -cp /h2/bin/h2.jar org.h2.tools.Server \
-web -webAllowOthers -tcp -tcpAllowOthers -baseDir $H2DATA
