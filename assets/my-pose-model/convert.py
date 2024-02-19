import tensorflow as tf
# Convert the model.
model = tf.keras.models.load_model('hdf5_keras_model.hdf5')
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert() 
    
# Save the TF Lite model.
with tf.io.gfile.GFile('model.tflite', 'wb') as f:
    f.write(tflite_model)