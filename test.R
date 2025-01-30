rextendr::document()
devtools::load_all()

Sys.setenv("ORT_DYLIB_PATH"="/nix/store/rrp6kppq6jlqj765bqkab2lr6mizhix0-onnxruntime-1.18.1/lib/libonnxruntime.so")

new_inference_session("_model/", model = "model_O3.onnx")


