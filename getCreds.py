import boto

try:
    from secret import AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
except:
    AWS_ACCESS_KEY_ID = None
    AWS_SECRET_ACCESS_KEY = None

conn = boto.connect_s3(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
bucket = conn.get_bucket('0NK38GF20CCT6VYTBG02'.lower() + '-keys')
bucket.get_key('client.key').get_contents_to_filename('client.key')
bucket.get_key('client.crt').get_contents_to_filename('client.crt')
bucket.get_key('myca.crt').get_contents_to_filename('myca.crt')
