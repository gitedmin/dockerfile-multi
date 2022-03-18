FROM trion/ng-cli as builder
#sample
WORKDIR /app
COPY package.json package.json
COPY package-lock.json package-lock.json
RUN npm ci  --debug 
COPY . .
RUN ng build --prod

FROM nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder  /app/dist /usr/share/nginx/html
