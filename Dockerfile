FROM node:16-alpine
WORKDIR ./app
COPY . .
RUN npm i
# In a prod-ready app, this would run start, rather than dev. But that would require secrets management to be set up.
CMD ["npm", "run", "dev"]
