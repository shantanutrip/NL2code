output="runs"
device="cuda0"

## Originally the batch size was 10 and epoch size was 200 for hs
if [ "$2" == "gColab" ]; then
  echo "Google Colab running"
	batch_size=10
  max_epoch_size=10
else
	batch_size=5
  max_epoch_size=10
fi

echo "batch size : ${batch_size}"
echo "max epoch size : ${batch_size}"

if [ "$1" == "hs" ]; then
	# hs dataset
	echo "training hs dataset"
	dataset="hs.freq3.pre_suf.unary_closure.bin"
	commandline="-batch_size ${batch_size} -max_epoch ${max_epoch_size} -valid_per_batch 280 -save_per_batch 280 -decode_max_time_step 350 -optimizer adadelta -rule_embed_dim 128 -node_embed_dim 64 -valid_metric bleu"
	datatype="hs"
else
	# django dataset
	echo "training django dataset"
	dataset="django.cleaned.dataset.freq5.par_info.refact.space_only.bin"
	commandline="-batch_size 10 -max_epoch 50 -valid_per_batch 4000 -save_per_batch 4000 -decode_max_time_step 100 -optimizer adam -rule_embed_dim 128 -node_embed_dim 64 -valid_metric bleu"
	datatype="django"
fi

# train the model
THEANO_FLAGS="mode=FAST_RUN,device=${device},floatX=float32" python -u code_gen.py \
	-data_type ${datatype} \
	-data data/${dataset} \
	-output_dir ${output} \
	${commandline} \
	train

# decode testing set, and evaluate the model which achieves the best bleu and accuracy, resp.
for model in "model.best_bleu.npz" "model.best_acc.npz"; do
	THEANO_FLAGS="mode=FAST_RUN,device=${device},floatX=float32" python code_gen.py \
	-data_type ${datatype} \
	-data data/${dataset} \
	-output_dir ${output} \
	-model ${output}/${model} \
	${commandline} \
	decode \
	-saveto ${output}/${model}.decode_results.test.bin

	python code_gen.py \
		-data_type ${datatype} \
		-data data/${dataset} \
		-output_dir ${output} \
		evaluate \
		-input ${output}/${model}.decode_results.test.bin
done
