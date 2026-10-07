from flask import Flask, jsonify
import os, time
app=Flask(__name__); START=time.time()
@app.get('/')
def root(): return jsonify(service='final-devops-api',status='ok',version=os.getenv('APP_VERSION','dev'))
@app.get('/health')
def health(): return jsonify(status='healthy')
@app.get('/ready')
def ready(): return jsonify(status='ready')
@app.get('/metrics')
def metrics():
    return (f"# HELP app_uptime_seconds Application uptime\n# TYPE app_uptime_seconds gauge\napp_uptime_seconds {time.time()-START:.2f}\n",200,{'Content-Type':'text/plain; version=0.0.4'})
@app.get('/config')
def config(): return jsonify(environment=os.getenv('APP_ENV','unknown'),log_level=os.getenv('LOG_LEVEL','INFO'),database_url_configured=bool(os.getenv('DATABASE_URL')))
if __name__=='__main__': app.run(host='0.0.0.0',port=int(os.getenv('PORT','8080')))
