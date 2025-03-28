using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Interop;
using System.Text;

using static zstd.zstd;

namespace example;

static class Program
{
	typealias size_t = uint;
	typealias char = char8;

	static int Main(params String[] args)
	{
		String str = """
			Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sodales pharetra est et feugiat. Suspendisse molestie, lacus ac auctor dignissim, lacus sapien gravida augue, nec posuere ex lorem eget metus. Sed vitae molestie justo. Nullam nulla arcu, ullamcorper a nibh vitae, congue dapibus tellus. Proin dignissim malesuada libero in sagittis. Aliquam convallis nisl scelerisque rutrum rhoncus. Integer hendrerit condimentum risus a dignissim. Cras imperdiet nisl metus, in ornare nisl convallis et. Aenean mi turpis, varius faucibus posuere ut, eleifend id ligula. Duis ex neque, maximus sed malesuada sit amet, lacinia sit amet tellus.
		
			Ut sit amet risus eros. Nunc facilisis venenatis venenatis. Ut condimentum tristique placerat. Nulla suscipit odio sit amet tincidunt tincidunt. Sed nec suscipit ligula. Aenean nec nisl fermentum, viverra ex dapibus, venenatis sapien. Aliquam ipsum est, vestibulum sit amet ligula id, finibus rutrum dolor. In hac habitasse platea dictumst. Quisque vitae semper lorem. Nulla neque mi, maximus et fringilla nec, suscipit et magna. Etiam non metus vitae felis aliquam interdum a et felis.
		
			Vivamus molestie cursus congue. Nunc lorem eros, viverra ac porta nec, accumsan in lectus. Morbi consequat fringilla turpis, quis sodales felis commodo non. Aliquam molestie risus sit amet est bibendum egestas. Mauris vel nunc blandit, scelerisque diam at, eleifend ante. Morbi tincidunt, purus nec semper eleifend, libero libero laoreet odio, at tincidunt diam quam at felis. Mauris fringilla odio ac mauris lacinia mollis. Nam pellentesque pretium egestas. Cras sagittis porta eros, vel convallis odio mollis eget. Fusce ornare turpis eu felis molestie porttitor. Nulla aliquet diam quis sapien gravida, quis congue odio viverra. Morbi id blandit lacus. Sed accumsan ligula eget risus vulputate, ut euismod turpis tristique. Integer finibus mi in semper pharetra. Suspendisse non nulla ut metus pulvinar ornare non a orci. Maecenas efficitur sit amet quam in sollicitudin.
		
			Integer vitae dictum leo. Mauris placerat tellus sit amet ipsum faucibus egestas. Praesent eget orci ac quam fermentum placerat hendrerit eu enim. Donec ac felis in enim auctor semper. Suspendisse potenti. Nulla sollicitudin, lorem non varius consectetur, arcu elit sodales nisi, vel vehicula quam lacus sed sapien. Integer dapibus congue auctor. Phasellus venenatis suscipit tellus sed venenatis. In molestie nunc sit amet augue ornare laoreet. Vestibulum vitae lorem eu massa iaculis aliquet. Donec sit amet elit felis.
		
			Cras hendrerit consequat rhoncus. Nulla sagittis augue ac quam tristique, quis faucibus odio pretium. Phasellus vitae elementum metus. Praesent nec tincidunt elit. Aliquam quis ultrices magna, quis semper eros. Mauris tincidunt felis nec libero ullamcorper faucibus. Pellentesque eleifend id orci at vestibulum. Aliquam erat volutpat. Quisque sed nunc laoreet, finibus ligula quis, suscipit leo. Etiam consectetur nibh nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vestibulum arcu vitae dui varius, in aliquet mi bibendum. Aenean accumsan lectus nibh. Sed a nisl neque. Cras ut quam erat. Phasellus hendrerit ac velit egestas laoreet.
		""";

		char8* buf_compressed = (char8*)Internal.StdMalloc((.)str.Length);

		size_t size_compressed = ZSTD_compress(buf_compressed, (.)str.Length, str.Ptr, (.)str.Length, ZSTD_maxCLevel());

		Debug.WriteLine($"original size: {str.Length}");
		Debug.WriteLine($"compressed size: {size_compressed}");
		Debug.WriteLine($"compression ration: {str.Length / (float)size_compressed}");

		c_ulonglong size_framecontent = ZSTD_getFrameContentSize(buf_compressed, size_compressed);

		char8* buf_decompressed = (char8*)Internal.StdMalloc((.)size_framecontent);

		ZSTD_decompress(buf_decompressed, size_framecontent, buf_compressed, size_compressed);

		Debug.WriteLine(StringView(buf_decompressed, str.Length));

		return 0;
	}
}