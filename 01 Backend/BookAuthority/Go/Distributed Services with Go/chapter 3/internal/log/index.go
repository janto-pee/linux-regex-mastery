package log
import (
"io"
"os"
"github.com/tysontate/gommap"
)
var (
offWidth uint64 = 4
posWidth uint64 = 8
entWidth = offWidth + posWidth
)
type index struct {
	file *os.File
	mmap gommap.MMap
	size uint64
	}

	func newIndex(f *os.File, c Config) (*index, error) {
		idx := &index{
		file: f,
		}
		fi, err := os.Stat(f.Name())
		if err != nil {
		return nil, err
		}
		idx.size = uint64(fi.Size())
		if err = os.Truncate(
		f.Name(), int64(c.Segment.MaxIndexBytes),
		); err != nil {
		return nil, err
		}
		if idx.mmap, err = gommap.Map(
		idx.file.Fd(),
		gommap.PROT_READ|gommap.PROT_WRITE,
		gommap.MAP_SHARED,
		); err != nil {
		return nil, err
		}
		return idx, nil
		}
		// close\
		func (i *index) Close() error {
			if err := i.mmap.Sync(gommap.MS_SYNC); err != nil {
			return err
			}
			if err := i.file.Sync(); err != nil {
			return err
			}
			if err := i.file.Truncate(int64(i.size)); err != nil {
			return err
			}
			return i.file.Close()
			}
			func (i *index) Read(in int64) (out uint32, pos uint64, err error) {
				if i.size == 0 {
				return 0, 0, io.EOF
				}
				if in == -1 {
				out = uint32((i.size / entWidth) - 1)
				} else {
				out = uint32(in)
				}
				pos = uint64(out) * entWidth
				if i.size < pos+entWidth {
				return 0, 0, io.EOF
				}
				out = enc.Uint32(i.mmap[pos : pos+offWidth])
				pos = enc.Uint64(i.mmap[pos+offWidth : pos+entWidth])
				return out, pos, nil
				}
							