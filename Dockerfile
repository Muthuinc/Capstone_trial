FROM node:14 As build

WORKDIR /muthu

ENV GIT_COMMIT=${GIT_COMMIT}

COPY *.json .

RUN npm install

COPY . ./

RUN npm run build

FROM nginx:alpine

COPY --from=build /muthu/build/ /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
