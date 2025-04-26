// Functions for computing statistics on arrays of data

float compute_mean(int *data, int data_length);
float compute_variance(int *data, int data_length);

float compute_mean(int data[], int data_length){
	float mean = 0.0;
	for (int i = 0; i < data_length; i++){
		mean += data[i];
	}
    return mean/data_length;
}

float compute_variance(int data[], int data_length){
	float mean = compute_mean(data,data_length);
    float var = 0.0;
    for (int i = 0; i<data_length;i++){
        var += (data[i] - mean)*(data[i] - mean);
    }
    return var/data_length;
}