def readGasReadings():
	gasDetected = False
	while True:
		# value = mcp.read_adc(0)
		# if value > 400:
		# 	if not gasDetected:
		# 		gasDetected = True
		# 		GPIO.output(alert, True)
		# 		print(value)
		# 		sms.send("Gas Leakage Detected",configfile.number)
                #                 pin_status['gas_leakage'] = 1
		# else:
		# 	if gasDetected:
		# 		GPIO.output(alert, False)
		# 		gasDetected = False
		# 		print(value)
                #                 pin_status['gas_leakage'] = 0

		time.sleep(0.01)

def indicateStart(led):
	pass
	# GPIO.output(led, False)
	# time.sleep(2)
	# GPIO.output(led, True)
	# time.sleep(0.5)
	# GPIO.output(led, False)
	# time.sleep(0.2)
	# GPIO.output(led, True)
	# time.sleep(0.2)
	# GPIO.output(led, False)
	# time.sleep(0.5)
	# GPIO.output(led, True)
        


from flask import Flask
from flask import jsonify
# import RPi.GPIO as GPIO
import threading
import time
# import Adafruit_GPIO.SPI as SPI
# import Adafruit_MCP3008
# import sms
# import configfile

# GPIO.setmode(GPIO.BOARD)
relay1 = 7
relay2 = 11
relay3 = 13
alert = 15
start_led = 40
pin_status = {'switch1':0, 'switch2':0, 'switch3':0, 'gas_leakage':0}

# GPIO.setup(relay1, GPIO.OUT)
# GPIO.setup(relay2, GPIO.OUT)
# GPIO.setup(relay3, GPIO.OUT)
# GPIO.setup(alert, GPIO.OUT)
# GPIO.setup(start_led, GPIO.OUT)
# GPIO.setwarnings(False)
indicateStart(start_led)

# Hardware SPI configuration:
# SPI_PORT   = 0
# SPI_DEVICE = 0
# mcp = Adafruit_MCP3008.MCP3008(spi=SPI.SpiDev(SPI_PORT, SPI_DEVICE))

gasRead = threading.Thread(target=readGasReadings)
gasRead.start()

app = Flask(__name__)

@app.route('/')
def index():
        # return "Showing Status"
	return jsonify(pin_status)

@app.route('/switch1/<int:state>')
def switch1(state):
	pin_status['switch1'] = state
	# if state == 1:
		# GPIO.output(relay1, True)
		# return "Switch 1 Turned on"
	# else:
		# GPIO.output(relay1, False)
		# return "Switch 1 turned off"
	return jsonify(pin_status)

@app.route('/switch2/<int:state>')
def switch2(state):
        pin_status['switch2'] = state
        # if state == 1:
                # GPIO.output(relay2, True)
                # return "Switch 2 Turned on"
        # else:
                # GPIO.output(relay2, False)
                # return "Switch 2 turned off"
        return jsonify(pin_status)

@app.route('/switch3/<int:state>')
def switch3(state):
        pin_status['switch3'] = state
        # if state == 1:
                # GPIO.output(relay3, True)
                # return "Switch 3 Turned on"
        # else:
                # GPIO.output(relay3, False)
                # return "Switch 3 turned off"
        return jsonify(pin_status)

if __name__ == "__main__":
        app.run(debug=True)
