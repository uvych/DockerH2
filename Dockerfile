FROM openjdk:latest

ENV H2DATA /h2-data
ENV RELEASE_DATE 2017-04-23

RUN curl http://www.h2database.com/h2-$RELEASE_DATE.zip -o h2.zip \ 
&& unzip h2.zip -d . \ 
&& rm h2.zip

RUN ln -s $(ls /h2/bin/*jar) /h2/bin/h2.jar

RUN mkdir /docker-entrypoint-initdb.d

RUN echo 'CREATE ALIAS IF NOT EXISTS MYFUNCTION AS $$ String mrpc9000(String inv , String out) throws Exception {out = inv; return out;} $$' > /docker-entrypoint-initdb.d/my-db-name.sql

VOlUME /h2-data

EXPOSE 8082 9092

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD java -cp /h2/bin/h2.jar org.h2.tools.Server \
-web -webAllowOthers -tcp -tcpAllowOthers -baseDir $H2DATA
