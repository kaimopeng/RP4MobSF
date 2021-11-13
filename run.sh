export FORWARD_HOST=172.17.0.1
export FORWARD_PORT=8000

CUR_DIR=`pwd`
CONF_DIR=$CUR_DIR/conf/conf.d
PKI_DIR=$CUR_DIR/conf/pki
AUTH_DIR=$CUR_DIR/conf/auth
envsubst < auth.conf.template > $CONF_DIR/auth.conf

docker run -p 80:80 -p 443:443 \
  -e 'DH_SIZE=512' \
  -v $CONF_DIR:/etc/nginx/conf.d:rw \
  -v $PKI_DIR:/etc/nginx/pki:rw \
  -v $AUTH_DIR:/etc/nginx/auth:ro \
  --name nginx_mobsf \
  rp4mobsf:latest
