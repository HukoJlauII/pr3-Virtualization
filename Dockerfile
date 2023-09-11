FROM gradle AS TEMP_BUILD_IMAGE
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY build.gradle settings.gradle $APP_HOME

COPY gradle $APP_HOME/gradle
COPY --chown=gradle:gradle . /home/gradle/src
USER root
RUN chown -R gradle /home/gradle/src

RUN gradle build || return 0

ADD . .
RUN wget -O ./src/main/resources/mirea.png https://www.mirea.ru/upload/medialibrary/80f/MIREA_Gerb_Colour.png

RUN gradle clean build
ONBUILD CMD ["echo","Glushko Nikita Sergeevich Zhiznevskiy Nikita Vyacheslavovich"]


FROM amazoncorretto:17
ENV ARTIFACT_NAME=pr3-0.0.1-SNAPSHOT.jar
ENV APP_HOME=/usr/app/
ENV DB_PORT=5432
VOLUME "myApp"
WORKDIR $APP_HOME

COPY --from=TEMP_BUILD_IMAGE $APP_HOME/build/libs/$ARTIFACT_NAME .
LABEL "authors"="Глушко Никита Сергеевич/Жизневский Никита Вячеславович ИКБО-16-20"

EXPOSE 8080
ENTRYPOINT exec java -Dspring.datasource.url=jdbc:postgresql://host.docker.internal:$DB_PORT/postgres -jar ${ARTIFACT_NAME}
ONBUILD CMD ["echo","Сборка и запуск произведены. Автор: Глушко Никита Сергеевич/Жизневский Никита Вячеславович"]

