from nn.utils.generic_utils import init_logging
from nn.utils.io_utils import deserialize_from_file, serialize_to_file
print('Hi')
print('Hello')

train_data, dev_data, test_data = deserialize_from_file('/content/NL2code/data/hs.freq3.pre_suf.unary_closure.bin')

print('Total Grammar Rules: ' + str(len(train_data.grammar.rules)))
print('Total Annotation Vocabs: ' + str(len(train_data.annot_vocab.token_id_map)))
print('Total Terminal Vocabs: ' + str(len(train_data.terminal_vocab.token_id_map)))
print('Total examples: ' + str(train_data.examples))

print('-' * 100)
for i, grammar_rule in enumerate(train_data.grammar.rules):
    print(grammar_rule)
    if i == 10:
      break

print('-' * 100)
for i, annot_vocab in enumerate(train_data.annot_vocab.token_id_map):
  print(annot_vocab)
  if i == 50:
    break

print('-' * 100)
for i, annot_vocab in enumerate(train_data.annot_vocab.token_id_map):
  print(annot_vocab)
  if i == 50:
    break

print('-' * 100) 
for i, terminal_vocab in enumerate(train_data.terminal_vocab.token_id_map):
  print(terminal_vocab)
  if i == 50:
    break

print('-' * 100) 
for i, example in enumerate(train_data.examples):
  print(example.parse_tree)
  print(example.code)
  if i == 1:
    break

# print(train_data.examples[0].parse_tree)

# print(train_data.annot_vocab.token_id_map)
# print(train_data.terminal_vocab.token_id_map)
# print(train_data.grammar.rules)
# print(train_data.grammar.node_type_to_id)