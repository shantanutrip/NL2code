def init():
    global universal_data_storage_dict
    universal_data_storage_dict = {}

def save_universal_data_storage_dict():
    import pickle
    pickle_out = open("universal_data_storage.pickle","wb")
    pickle.dump(universal_data_storage_dict, pickle_out)
    pickle_out.close()