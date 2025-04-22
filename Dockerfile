FROM node:18

# Tạo user và group với home directory hợp lệ
RUN addgroup --system appgroup && \
    adduser --system --ingroup appgroup --home /home/appuser appuser

# Tạo home và thư mục làm việc, set quyền
RUN mkdir -p /home/appuser /app && \
    chown -R appuser:appgroup /home/appuser /app

WORKDIR /app

# Copy package.json
COPY package.json ./
RUN chown -R appuser:appgroup /app

# Chuyển sang user không phải root
USER appuser

# Cài dependencies
RUN npm install

# Copy source code
COPY --chown=appuser:appgroup src ./src
COPY --chown=appuser:appgroup public ./public

EXPOSE 3000

CMD ["npm", "start"]
