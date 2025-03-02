{{- define "default.conf" -}}
default.conf: |
    server {
        listen       8080;
        listen  [::]:8080;
        server_name  localhost;
        location / {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
  index.html: |
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <title>Welcome to Kubernetes!</title>
    <style>
    html { color-scheme: light dark; }
    body { width: 35em; margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif; }
    </style>
    </head>
    <body>
    <h1>Hello, Kubernetes!</h1>
    </body>
    </html>  
{{- end }}

{{- define "deploy.container.settings"}}
resources:
  limits:
    memory: 500Mi
  requests:
    memory: 250Mi
volumeMounts:
  - name: nginx-default-backend-conf
    mountPath: /etc/nginx/conf.d/default.conf
    subPath: default.conf
    readOnly: true
  - name: nginx-default-backend-conf
    mountPath: /usr/share/nginx/html/index.html
    subPath: index.html
    readOnly: true
{{- end}}